import CoursesView from "@/views/Courses/CoursesView.vue";
import AssigmentView from "@/views/Assigment/AssigmentView.vue";
const coursesRoutes = [
  {
    path: '/teacher/courses',
    name: 'teacherCourses',
    component: CoursesView,
    meta: {
      title: 'Courses',
    },
  },
  {
    path: '/teacher/assigments/:id',
    name: 'teacherAssigments',
    component: AssigmentView,
    meta: {
      title: 'Assigments',
    },
  }
];

export default coursesRoutes;
