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
    },
  },
  {
    path: '/student/courses',  // Dynamic segment for id
    name: 'CoursesStudent',
    component: CoursesView,
    meta: {
      title: 'My Courses',
    },
  },
  {
    path: '/student/assigments/:id',  // Dynamic segment for id
    name: 'AssigmentsStudent',
    component: AssigmenstView,
    meta: {
      title: 'My Assigements',
    },
  },
  {
    path: '/student/enrrolment',  // Dynamic segment for id
    name: 'Enrollments',
    component: EnrollmentView,
    meta: {
      title: 'Enrrolments',
    },
  }

];

export default assigmentsRoutes;
