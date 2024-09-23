// src/router/authRoutes.ts

import SigninView from '@/views/Authentication/SigninView.vue';
import SignupView from '@/views/Authentication/SignupView.vue';
import authTeacherRoutes from '../teacher/auth/authTeacherRoutes';
import authStudentRoutes from '../student/auth/authStudentRoutes';
const authRoutes = [
  {
    path: '/auth/signin',
    name: 'signin',
    component: SigninView,
    meta: {
      title: 'Signin',
    },
  },
  {
    path: '/auth/signup',
    name: 'signup',
    component: SignupView,
    meta: {
      title: 'Signup',
    },
  },
  ...authTeacherRoutes,
  ...authStudentRoutes
];


export default authRoutes;
