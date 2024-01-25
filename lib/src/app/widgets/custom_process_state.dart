import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/app/widgets/empty_widget.dart';
import 'package:flutter_alcore/src/app/widgets/error_widget.dart';
import 'package:flutter_alcore/src/data/api/api_exception.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';

import 'loading_widget.dart';

@immutable
abstract class ProcessState {}

class ProcessInitialState extends ProcessState {}

class ProcessLoadingState extends ProcessState {}

class ProcessSuccessState<T> extends ProcessState {
  final String? message;
  final T? data;
  ProcessSuccessState(this.message, this.data);
}

class ProcessSuccessWithLoadMoreState<T> extends ProcessState {
  final String? message;
  final T? allData;
  final T? lastFetcedData;
  ProcessSuccessWithLoadMoreState(
      this.message, this.allData, this.lastFetcedData);
}

class ProcessEmptyState extends ProcessState {}

class ProcessErrorState extends ProcessState {
  final String? message;
  ProcessErrorState(this.message);
}

//cara 1 raw handle
Rx<ProcessState> createNewProcessState() {
  return Rx<ProcessState>(ProcessInitialState());
}

//cara 2 constructor ProcessStateImpl
class ProcessStateImpl<DT, RQT, RPT> extends Rx<ProcessState> {
  DT? data;
  RQT? request;
  RPT? response;
  String? message;
  Future<RPT> Function(RQT request)? getResponse;
  bool Function(RPT response)? isSuccessfull;
  bool Function(RPT response)? isEmpty;
  String? Function(RPT response)? getMessage;
  DT? Function(RPT response)? getData;
  RQT Function(RQT request)? modifyRequest;
  ProcessStateImpl(
      {this.getResponse,
      this.isSuccessfull,
      this.isEmpty,
      this.getMessage,
      this.getData,
      this.modifyRequest})
      : super(ProcessInitialState()) {
    isEmpty ??= (response) => false;
    modifyRequest ??= (request) => request;
  }

  void setAsInitial() {
    value = ProcessInitialState();
  }

  void setAsLoading() {
    value = ProcessLoadingState();
  }

  bool isStateLoading() {
    return value is ProcessLoadingState;
  }

  void setAsEmpty() {
    value = ProcessEmptyState();
  }

  bool isStateEmpty() {
    return value is ProcessEmptyState;
  }

  void setAsSuccess<T>(String? message, T? data) {
    value = ProcessSuccessState("", data);
  }

  bool isStateSuccess() {
    return value is ProcessSuccessState;
  }

  void setAsError(String? message) {
    value = ProcessErrorState(message);
  }

  bool isStateError() {
    return value is ProcessErrorState;
  }

  late ProcessStateBuilder builder;
  Obx obx<T>({required ProcessStateBuilder<T> builder}) {
    this.builder = builder;
    return Obx(() {
      if (value is ProcessInitialState) {
        //initial state
        return builder.whenInitial != null
            ? builder.whenInitial!()
            : Container();
      } else if (value is ProcessLoadingState) {
        //loading state

        if (builder.showInitialWhenLoading) {
          if (builder.whenInitial != null) {
            return builder.whenInitial!();
          } else {
            throw Exception(
                "if showInitialWhenLoading true, builderWhenInitial must not be null");
          }
        }

        return builder.whenLoading != null
            ? builder.whenLoading!()
            : const CustomLoadingWidget();
      } else if (value is ProcessSuccessState) {
        //success state
        if (builder.showInitialWhenSuccess) {
          if (builder.whenInitial != null) {
            return builder.whenInitial!();
          } else {
            throw Exception(
                "if showInitialWhenSuccess true, builderWhenInitial must not be null");
          }
        }

        var successValue = value as ProcessSuccessState<T>;
        return builder.whenSuccess != null
            ? builder.whenSuccess!(successValue.message, successValue.data as T)
            : (builder.whenInitial != null
                ? builder.whenInitial!()
                : Container());
      } else if (value is ProcessSuccessWithLoadMoreState) {
        //success with load more state
        if (builder.showInitialWhenSuccessWithLoadMore) {
          if (builder.whenInitial != null) {
            return builder.whenInitial!();
          } else {
            throw Exception(
                "if showInitialWhenSuccessWithLoadMore true, builderWhenInitial must not be null");
          }
        }

        var successValue = value as ProcessSuccessWithLoadMoreState<T>;
        ProcessStateImplWithLoadMore obj = this as ProcessStateImplWithLoadMore;
        return builder.whenSuccessWithLoadMore != null
            ? LoadMore(
                onLoadMore: obj.loadMore,
                isFinish: !obj.hasMore.value,
                textBuilder: builderTextLoadMore,
                child: builder.whenSuccessWithLoadMore!(
                    successValue.message,
                    successValue.allData as T,
                    successValue.lastFetcedData as T),
              )
            : (builder.whenInitial != null
                ? builder.whenInitial!()
                : Container());
      } else if (value is ProcessEmptyState) {
        //empty state
        if (builder.showInitialWhenEmpty) {
          if (builder.whenInitial != null) {
            return builder.whenInitial!();
          } else {
            throw Exception(
                "if showInitialWhenEmpty true, builderWhenInitial must not be null");
          }
        }

        return builder.whenEmpty != null
            ? builder.whenEmpty!()
            : const CustomEmptyWidget();
      } else if (value is ProcessErrorState) {
        //error state
        if (builder.showInitialWhenError) {
          if (builder.whenInitial != null) {
            return builder.whenInitial!();
          } else {
            throw Exception(
                "if showInitialWhenError true, builderWhenInitial must not be null");
          }
        }
        var errorValue = value as ProcessErrorState;
        return builder.whenError != null
            ? builder.whenError!(errorValue.message)
            : CustomErrorWidget(
                errorMessage: errorValue.message,
                onAction: () {
                  if (this is ProcessStateImpl ||
                      this is ProcessStateImplWithLoadMore) {
                    ProcessStateImpl obj = this as ProcessStateImpl;
                    obj.refetch();
                  }
                },
              );
      }
      return (builder.whenInitial != null
          ? builder.whenInitial!()
          : Container());
    });
  }

  void setCallbacks(
      {Future<RPT> Function(RQT request)? getResponse,
      bool Function(RPT response)? isSuccessfull,
      bool Function(RPT response)? isEmpty,
      String? Function(RPT response)? getMessage,
      DT? Function(RPT response)? getData,
      RQT Function(RQT request)? modifyRequest}) {
    this.getResponse = getResponse;
    this.isSuccessfull = isSuccessfull;
    this.isEmpty = isEmpty;
    this.getMessage = getMessage;
    this.getData = getData;
    this.modifyRequest = modifyRequest;
  }

  Future<void> refetch() async {
    if (request != null) {
      fetch(request as RQT);
    }
  }

  Future<bool> fetch(RQT request) async {
    try {
      reset();
      setAsLoading();
      this.request = request;
      modifyRequest?.call(this.request as RQT);
      response = await getResponse?.call(request);

      message = getMessage?.call(response as RPT);
      if (isSuccessfull?.call(response as RPT) ?? true) {
        data = getData?.call(response as RPT);
        if (isEmpty?.call(response as RPT) ?? false) {
          setAsEmpty();
        } else {
          setAsSuccess<DT>(message, data);
        }
        return true;
      } else {
        setAsError(message);
        return false;
      }
    } catch (e) {
      message = e.toString();
      setAsError(message);
      handleUnAuthorized(e, fetch, request);
      return false;
    }
  }

  void reset() {
    data = null;
    request = null;
    response = null;
  }
}

class ProcessStateBuilder<T> {
  Widget Function()? whenInitial;
  bool showInitialWhenLoading;
  Widget Function()? whenLoading;
  bool showInitialWhenSuccess;
  Widget Function(String? message, T data)? whenSuccess;
  bool showInitialWhenSuccessWithLoadMore;
  Widget Function(String? message, T allData, T lastFetchedData)?
      whenSuccessWithLoadMore;
  bool showInitialWhenEmpty;
  Widget Function()? whenEmpty;
  bool showInitialWhenError;
  Widget Function(String? message)? whenError;
  ProcessStateBuilder({
    this.whenInitial,
    this.showInitialWhenLoading = false,
    this.whenLoading,
    this.showInitialWhenSuccess = false,
    this.whenSuccess,
    this.showInitialWhenSuccessWithLoadMore = false,
    this.whenSuccessWithLoadMore,
    this.showInitialWhenEmpty = false,
    this.whenEmpty,
    this.showInitialWhenError = false,
    this.whenError,
  });
}

//cara 3 constructor ProcessStateImplWithLoadMore with library loadmore
class ProcessStateImplWithLoadMore<DT, RQT, RPT>
    extends ProcessStateImpl<List<DT>, RQT, RPT> {
  List<DT>? lastFetchedData;
  var hasMore = false.obs;
  late bool initialHasMore;
  String? nextPage = ""; //page number
  (bool, String) Function(RPT response) checkHasMore;
  void Function(RQT request, String nextPage) updateNextPage;
  ProcessStateImplWithLoadMore({
    required super.getResponse,
    required super.isSuccessfull,
    super.isEmpty,
    required super.getMessage,
    required super.getData,
    required this.checkHasMore,
    required this.updateNextPage,
    super.modifyRequest,
    this.initialHasMore = false,
  }) {
    this.hasMore.value = initialHasMore;
  }

  @override
  Future<bool> fetch(RQT request) async {
    try {
      reset();
      setAsLoading();
      this.request = request;
      modifyRequest?.call(this.request as RQT);
      response = await getResponse?.call(request);
      message = getMessage?.call(response as RPT);
      if (isSuccessfull?.call(response as RPT) ?? true) {
        lastFetchedData = getData?.call(response as RPT);
        data = lastFetchedData;
        if (isEmpty!(response as RPT)) {
          setAsEmpty();
        } else {
          setAsSuccessWithLoadMore<List<DT>>(message, data, lastFetchedData);
        }
        var (more, next) = checkHasMore(response as RPT);
        hasMore.value = more;
        if (more) {
          nextPage = next;
          updateNextPage(request, nextPage!);
        }
        return true;
      } else {
        setAsError(message);
        return false;
      }
    } catch (e) {
      message = e.toString();
      setAsError(message);
      handleUnAuthorized(e, fetch, request);
      return false;
    }
  }

  void setAsSuccessWithLoadMore<T>(
      String? message, T? allData, T? lastFetchedData) {
    value = ProcessSuccessWithLoadMoreState("", allData, lastFetchedData);
  }

  bool isStateSuccessWithLoadMore() {
    return value is ProcessSuccessWithLoadMoreState;
  }

  Future<bool> loadMore() async {
    try {
      var response = await super.getResponse?.call(super.request as RQT);
      if (response != null && (isSuccessfull?.call(response) ?? false)) {
        lastFetchedData = null;
        if (!isEmpty!(response)) {
          lastFetchedData = super.getData?.call(response)!;
          data?.addAll(lastFetchedData ?? []);
        }
        setAsSuccessWithLoadMore<List<DT>>(
            getMessage?.call(response), data, lastFetchedData);
        var (more, next) = checkHasMore(response);
        hasMore.value = more;
        if (more) {
          nextPage = next;
          updateNextPage(request as RQT, nextPage!);
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  void reset() {
    lastFetchedData = null;
    nextPage = "";
    hasMore.value = initialHasMore;
    super.reset();
  }
}

String builderTextLoadMore(LoadMoreStatus status) {
  String text;
  switch (status) {
    case LoadMoreStatus.fail:
      text = "Gagal memuat, ketuk untuk muat ulang";
      break;
    case LoadMoreStatus.idle:
      text = "Harap tunggu ya";
      break;
    case LoadMoreStatus.loading:
      text = "Harap tunggu ya...";
      break;
    case LoadMoreStatus.nomore:
      text = "Sudah semua data dimuat";
      break;
    default:
      text = "";
  }
  return text;
}

Future<bool> handleUnAuthorized<RQT>(
    Object e, void Function(RQT request) reloadFunction, RQT request) async {
  if (e is ApiExceptions && e.status.isUnauthorized) {
    // var result = await Get.toNamed(LoginPage.route);
    // if (result != null && result == true) {
    //   reloadFunction(request);
    // }
    return true;
  }
  return false;
}
