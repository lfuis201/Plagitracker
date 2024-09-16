// src/router/authRoutes.ts

import SigninView from '@/views/Teacher/auth/SigninView.vue';
import SignupView from '@/views/Teacher/auth/SignupView.vue';

const authTeacherRoutes = [
  {
    path: '/teacher/auth/signin',
    name: 'signin',
    component: SigninView,
    meta: {
      title: 'Signin',
    },
  },
  {
    path: '/teacher/auth/signup',
    name: 'signup',
    component: SignupView,
    meta: {
      title: 'Signup',
    },
  },
];

export default authTeacherRoutes;
