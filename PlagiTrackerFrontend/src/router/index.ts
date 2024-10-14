import { createRouter, createWebHistory } from 'vue-router'
import authRoutes from './auth/authRoutes'
import assigmentsRoutes from './student/assigments/assigmentsRoutes'
import coursesRoutes from './teacher/courses/coursesRoutes'
import UnauthorizedView from '@/views/UnauthorizedView.vue'
import HomeView from '@/views/HomeView.vue'
import ProfileView from '@/views/ProfileView.vue'
import NotFoundView from '@/views/NotFoundView.vue'
import ServerErrorView from '@/views/ServerErrorView.vue'
import ForgotPasswordView from '@/views/Authentication/ForgotPasswordView.vue'
import { useUserStore } from '@/stores/userStore'

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView, // Set HomeView as the default component for '/'
    meta: {
      title: 'Home'
    }
  },
  {
    path: '/:catchAll(.*)',
    name: 'NotFound',
    component: NotFoundView,
    meta: {
      title: 'Page Not Found'
    }
  },
  {
    path: '/unauthorized',
    name: 'unauthorized',
    component: UnauthorizedView,
    meta: {
      title: 'Unauthorized Access'
    }
  },
  {
    path: '/home',
    name: 'Home',
    component: HomeView,
    meta: {
      title: 'Home'
    }
  },
  {
    path: '/profile',
    name: 'profile',
    component: ProfileView,
    meta: {
      title: 'Profile',
      requiresAuth: true,
    }
  },
  {
    path: '/serverError', // Nueva ruta para errores de servidor
    name: 'ServerError',
    component: ServerErrorView,
    meta: {
      title: 'Server Error'
    }
  },
  
  {
    path: '/forgotPassword', // Nueva ruta para errores de servidor
    name: 'forgotPassword',
    component: ForgotPasswordView,
    meta: {
      title: 'Forgot Password'
    }
  },

  ...authRoutes,
  ...coursesRoutes,
  ...assigmentsRoutes
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
  scrollBehavior(to, from, savedPosition) {
    return savedPosition || { left: 0, top: 0 }
  }
})

router.beforeEach((to, from, next) => {
  document.title = `PlagiTracker ${to.meta.title}`
  next()
})

router.beforeEach((to, from, next) => {
  const userStore = useUserStore()
  const isAuthenticated = !!userStore.getUser // Check if user is authenticated
  const userRole = userStore.getRole // Get the current user's role

  console.log('Checking route:', to.path)
  console.log('Is authenticated:', isAuthenticated)
  console.log('User role:', userRole)

  // Check if the route requires authentication
  const requiresAuth = to.matched.some((record) => record.meta.requiresAuth)
  const allowedRoles = to.meta.allowedRoles // Get allowed roles for the route

  if (requiresAuth && !isAuthenticated) {
    // Redirect to the login page if not authenticated
    console.log('Redirecting to login: Not authenticated')
    next({ name: 'home' }) // Adjust this to your actual login route name
  } else if (requiresAuth && allowedRoles && !allowedRoles.includes(userRole)) {
    // Redirect if the user's role is not allowed for this route
    console.log('Redirecting to unauthorized: Role not allowed')
    next({ name: 'unauthorized' }) // Redirect to unauthorized page
  } else {
    // Proceed normally
    document.title = `PlagiTracker ${to.meta.title}`
    next()
  }
})

export default router
