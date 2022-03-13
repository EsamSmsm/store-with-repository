part of 'information_cubit.dart';

abstract class InformationState extends Equatable {
  const InformationState();
  @override
  List<Object> get props => [];
}

class InformationInitial extends InformationState {}

class GetSlideShowLoading extends InformationState{}

class GetSlideShowSuccess extends InformationState{}

class GetSlideShowFailed extends InformationState{
  final String error;

  const GetSlideShowFailed({required this.error});
}
