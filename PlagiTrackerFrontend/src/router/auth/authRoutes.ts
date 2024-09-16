// src/router/authRoutes.ts

import SigninView from '@/views/Authentication/SigninView.vue';
import SignupView from '@/views/Authentication/SignupView.vue';

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
];

export default authRoutes;
