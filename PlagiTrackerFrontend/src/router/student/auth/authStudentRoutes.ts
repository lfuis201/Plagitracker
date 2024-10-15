// src/router/authRoutes.ts

import SignupView from '@/views/Student/auth/SignupView.vue'
import SigninView from '@/views/Student/auth/SigninView.vue'
import ForgotPasswordView from '@/views/Student/auth/ForgotPasswordView.vue'
import ResetPasswordView from '@/views/Student/auth/ResetPasswordView.vue'

const authStudentRoutes = [
  {
    path: '/student/auth/signin',
    name: 'studentsignin',
    component: SigninView,
    meta: {
      title: 'StudentSignin',
      requiresAuth: false,
      allowedRoles: []
    }
  },
  {
    path: '/student/auth/signup',
    name: 'studentsignup',
    component: SignupView,
    meta: {
      title: 'StudentSignup',
      requiresAuth: false,
      allowedRoles: []
    }
  },
  {
    path: '/student/auth/forgotPassword',
    name: 'studentForgotPassword',
    component: ForgotPasswordView,
    meta: {
      title: 'Forgot Password',
      requiresAuth: false,
      allowedRoles: []
    }
  },
  {
    path: '/student/auth/ressetPassword',
    name: 'studentResetPassword',
    component: ResetPasswordView,
    meta: {
      title: 'Resset Password',
      requiresAuth: false,
      allowedRoles: []
    }
  }
]

export default authStudentRoutes
