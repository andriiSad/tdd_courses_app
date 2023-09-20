import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_courses_app/core/common/views/page_under_construction_view.dart';
import 'package:tdd_courses_app/core/extensions/context_extension.dart';
import 'package:tdd_courses_app/core/services/injection_container/injection_container.dart';
import 'package:tdd_courses_app/src/auth/data/models/user_model.dart';
import 'package:tdd_courses_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:tdd_courses_app/src/auth/presentation/views/sign_in_srceen.dart';
import 'package:tdd_courses_app/src/auth/presentation/views/sign_up_screen.dart';
import 'package:tdd_courses_app/src/dashboard/presentation/views/dashboard_screen.dart';
import 'package:tdd_courses_app/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:tdd_courses_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:tdd_courses_app/src/on_boarding/presentation/views/on_boarding_screen.dart';

part 'router_main.dart';
