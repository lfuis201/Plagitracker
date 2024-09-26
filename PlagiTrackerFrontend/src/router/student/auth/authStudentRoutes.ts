// src/router/authRoutes.ts

import SignupView from "@/views/Student/auth/SignupView.vue";
import SigninView from "@/views/Student/auth/SigninView.vue";
const authStudentRoutes = [
  {
    path: '/student/auth/signin',
    name: 'studentsignin',
    component: SigninView,
    meta: {
      title: 'StudentSignin',
      requiresAuth: false,
      allowedRoles: []
    },
  },
  {
    path: '/student/auth/signup',
    name: 'studentsignup',
    component: SignupView,
    meta: {
      title: 'StudentSignup',
      requiresAuth: false,
      allowedRoles: []
    },
  },
];

export default authStudentRoutes;
