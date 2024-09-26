import { createRouter, createWebHistory } from 'vue-router'
import authRoutes from './auth/authRoutes'
import assigmentsRoutes from './student/assigments/assigmentsRoutes'
import coursesRoutes from './teacher/courses/coursesRoutes'
import CalendarView from '@/views/CalendarView.vue'
import BasicChartView from '@/views/Charts/BasicChartView.vue'
import ECommerceView from '@/views/Dashboard/ECommerceView.vue'
import FormElementsView from '@/views/Forms/FormElementsView.vue'
import FormLayoutView from '@/views/Forms/FormLayoutView.vue'
import SettingsView from '@/views/Pages/SettingsView.vue'
import ProfileView from '@/views/ProfileView.vue'
import TablesView from '@/views/TablesView.vue'
import AlertsView from '@/views/UiElements/AlertsView.vue'
import ButtonsView from '@/views/UiElements/ButtonsView.vue'

import UnauthorizedView from '@/views/UnauthorizedView.vue'
import LoginView from '@/views/LoginView.vue'

import { useUserStore } from '@/stores/userStore'

const routes = [
  {
    path: '/unauthorized',
    name: 'unauthorized',
    component: UnauthorizedView,
    meta: {
      title: 'Unauthorized Access'
    }
  },
  {
    path: '/login',
    name: 'Login',
    component: LoginView,
    meta: {
      title: 'Login'
    }
  },
  {
    path: '/',
    name: 'eCommerce',
    component: ECommerceView,
    meta: {
      title: 'eCommerce Dashboard',
      requiresAuth: true,
      allowedRoles: []
    }
  },
  {
    path: '/calendar',
    name: 'calendar',
    component: CalendarView,
    meta: {
      title: 'Calendar'
    }
  },
  {
    path: '/profile',
    name: 'profile',
    component: ProfileView,
    meta: {
      title: 'Profile'
    }
  },
  {
    path: '/forms/form-elements',
    name: 'formElements',
    component: FormElementsView,
    meta: {
      title: 'Form Elements'
    }
  },
  {
    path: '/forms/form-layout',
    name: 'formLayout',
    component: FormLayoutView,
    meta: {
      title: 'Form Layout'
    }
  },
  {
    path: '/tables',
    name: 'tables',
    component: TablesView,
    meta: {
      title: 'Tables'
    }
  },
  {
    path: '/pages/settings',
    name: 'settings',
    component: SettingsView,
    meta: {
      title: 'Settings'
    }
  },
  {
    path: '/charts/basic-chart',
    name: 'basicChart',
    component: BasicChartView,
    meta: {
      title: 'Basic Chart'
    }
  },
  {
    path: '/ui-elements/alerts',
    name: 'alerts',
    component: AlertsView,
    meta: {
      title: 'Alerts'
    }
  },
  {
    path: '/ui-elements/buttons',
    name: 'buttons',
    component: ButtonsView,
    meta: {
      title: 'Buttons'
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
    next({ name: 'Login' }) // Adjust this to your actual login route name
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
