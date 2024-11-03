import AssigmenstView from "@/views/Student/Assigments/AssigmentsView.vue";
import SubmitForm from "@/views/Student/Assigments/SubmitForm.vue";

import CoursesView from "@/views/Student/Courses/CoursesView.vue";
import EnrollmentView from "@/views/Student/Enrollments/EnrollmentView.vue";

const assigmentsRoutes = [
  {
    path: '/student/submit/:id',  // Dynamic segment for id
    name: 'StudentSubmit',
    component: SubmitForm,
    meta: {
      title: 'Submit',
      requiresAuth: true,
      allowedRoles: ['student']
    },
  },
  {
    path: '/student/courses',  // Dynamic segment for id
    name: 'CoursesStudent',
    component: CoursesView,
    meta: {
      title: 'My Courses',
      requiresAuth: true,
      allowedRoles: ['student']
    },
  },
  {
    path: '/student/assigments/:id',  // Dynamic segment for id
    name: 'AssigmentsStudent',
    component: AssigmenstView,
    meta: {
      title: 'My Assignments',
      requiresAuth: true,
      allowedRoles: ['student']
    },
  },
  {
    path: '/student/enrrolment',  // Dynamic segment for id
    name: 'Enrollments',
    component: EnrollmentView,
    meta: {
      title: 'Enrrolments',
      requiresAuth: true,
      allowedRoles: ['student']
    },
  }

];

export default assigmentsRoutes;
