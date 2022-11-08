import 'package:wiine/blocs/auth/auth_events.dart';
import 'package:wiine/blocs/auth/auth_states.dart';
import 'package:wiine/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvents,AuthStates>{
  AuthRepo repo;
  AuthBloc(AuthStates LoginInitState,this.repo) : super(LoginInitState){
    on<StartAEvent>((event, emit) async {
      var pref= await SharedPreferences.getInstance();
      if(pref.getString('nom')!=''){
        emit(UserInState(nom: pref.getString('nom') ,email: pref.getString('email')));
      }

    });
    on<LoginButtonPressed>((event, emit) async {
      var pref= await SharedPreferences.getInstance();
      emit(LoginLoadingState()) ;
      var data = await repo.login(event.email,event.password);
      if(event.email==data['email']&&event.password==data['password']){
        pref.setString('nom', data['userName']);
        //pref.setString('place', data['place']);
        pref.setString('email', data['email']);
        emit(UserInState(nom: data['userName'] ,email: data['email']));

    }else {
        emit(LoginErrorState(message: 'Password is Wrong'));
      }
    });
    on<RegisterButtonPressed>((event, emit) async {
      var pref= await SharedPreferences.getInstance();
      var data = await repo.register(event.email,event.password,event.infos_liv,event.nom);
      emit(LoginLoadingState()) ;
      if(data['email']==event.email){
        emit(UserRegisterSuccessState());

      }else{
        emit(LoginErrorState(message: data['error']));
      }
    });
  }
}


