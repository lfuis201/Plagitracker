// src/router/authRoutes.ts

import SignupView from "@/views/Student/auth/SignupView.vue";
import SigninView from "@/views/Student/auth/SigninView.vue";
const authStudentRouters = [
  {
    path: '/student/auth/signin',
    name: 'signin',
    component: SigninView,
    meta: {
      title: 'Signin',
    },
  },
  {
    path: '/student/auth/signup',
    name: 'signup',
    component: SignupView,
    meta: {
      title: 'Signup',
    },
  },
];

export default authStudentRouters;
