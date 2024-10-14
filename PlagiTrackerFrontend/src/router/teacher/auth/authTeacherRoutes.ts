// src/router/authRoutes.ts

import SigninView from '@/views/Teacher/auth/SigninView.vue';
import SignupView from '@/views/Teacher/auth/SignupView.vue';
import ForgotPasswordView from '@/views/Teacher/auth/ForgotPasswordView.vue'

const authTeacherRoutes = [
  {
    path: '/teacher/auth/signin',
    name: 'teachersignin',
    component: SigninView,
    meta: {
      title: 'TeacherSignin',
      requiresAuth: false,
      allowedRoles: []
    },
  },
  {
    path: '/teacher/auth/signup',
    name: 'teachersignup',
    component: SignupView,
    meta: {
      title: 'TeacherSignup',
      requiresAuth: false,
      allowedRoles: []
    },
  },
  {
    path: '/teacher/auth/forgotPassword',
    name: 'teacherForgotPassword',
    component: ForgotPasswordView,
    meta: {
      title: 'Forgot Password',
      requiresAuth: false,
      allowedRoles: []
    },
  },
];

export default authTeacherRoutes;
