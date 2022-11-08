import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

class AuthEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class StartAEvent extends AuthEvents{}
class LoginButtonPressed extends AuthEvents{
  final String email ;
  final String password ;

  LoginButtonPressed({required this.email, required this.password});
}
class RegisterButtonPressed extends AuthEvents {
  final String email ;
  final String password ;
  final String infos_liv;
  final String nom;

  RegisterButtonPressed(
      {required this.email, required this.password, required this.infos_liv, required this.nom});
}

class UpdateButtonPressed extends AuthEvents {
  final String email ;
  final String password ;
  final String infos_liv;
  final String nom;

  UpdateButtonPressed(
      {required this.email, required this.password, required this.infos_liv, required this.nom});
}
class DecoButtonPressed extends AuthEvents{}
