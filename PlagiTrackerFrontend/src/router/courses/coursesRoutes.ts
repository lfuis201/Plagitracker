import CoursesView from "@/views/Courses/CoursesView.vue";
const coursesRoutes = [
  {
    path: '/teacher/courses',
    name: 'teacherCourses',
    component: CoursesView,
    meta: {
      title: 'Courses',
    },
  }
];

export default coursesRoutes;
