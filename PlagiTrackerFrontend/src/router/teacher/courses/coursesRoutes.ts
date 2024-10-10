import CoursesView from "@/views/Teacher/Courses/CoursesView.vue";
import AssigmentView from "@/views/Teacher/Assigment/AssigmentView.vue";
import SubmissionsView from "@/views/Teacher/Submissions/SubmissionsView.vue";

const coursesRoutes = [
  {
    path: '/teacher/courses',
    name: 'teacherCourses',
    component: CoursesView,
    meta: {
      title: 'Courses',
      requiresAuth: true,
      allowedRoles: ['teacher']
    },
  },
  {
    path: '/teacher/assigments/:id',
    name: 'teacherAssigments',
    component: AssigmentView,
    meta: {
      title: 'Assignments',
      requiresAuth: true,
      allowedRoles: ['teacher']
    },
  }
  ,
  {
    path: '/teacher/submissions/:id',
    name: 'teacherSubmissions',
    component: SubmissionsView,
    meta: {
      title: 'Submission',
      requiresAuth: true,
      allowedRoles: ['teacher']
    },
  }
];

export default coursesRoutes;
