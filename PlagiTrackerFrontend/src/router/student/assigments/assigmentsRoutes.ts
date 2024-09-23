import AssigmentView from "@/views/Student/Assigments/AssigmentView.vue";

const assigmentsRoutes = [
  {
    path: '/student/submit/:id',  // Dynamic segment for id
    name: 'Submit',
    component: AssigmentView,
    meta: {
      title: 'Submit',
    },
  }
];

export default assigmentsRoutes;
