// src/router/authRoutes.ts

import SigninView from '@/views/Teacher/auth/SigninView.vue';
import SignupView from '@/views/Teacher/auth/SignupView.vue';

const authTeacherRoutes = [
  {
    path: '/teacher/auth/signin',
    name: 'teachersignin',
    component: SigninView,
    meta: {
      title: 'TeacherSignin',
    },
  },
  {
    path: '/teacher/auth/signup',
    name: 'teachersignup',
    component: SignupView,
    meta: {
      title: 'TeacherSignup',
    },
  },
];

export default authTeacherRoutes;
