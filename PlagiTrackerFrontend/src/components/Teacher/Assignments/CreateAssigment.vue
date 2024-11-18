<template>
  <!-- ModalLayout that emits the 'close' event -->
  <ModalLayout :modalOpen="modalOpen" @close="handleClose" :disableClose="isSubmitting">
    <template #default>
      <h3 class="pb-2 text-xl font-bold text-black dark:text-white sm:text-2xl">
        Create Assignment
      </h3>
      <form @submit.prevent="handleSubmit">
        <!-- Assignment Title -->
        <div>
          <label for="assignmentTitle" class="block mb-2">Assignment Title</label>
          <input
            type="text"
            id="assignmentTitle"
            v-model="assignment.title"
            class="border rounded w-full px-3 py-2"
            required
          />
        </div>

        <!-- Assignment Description -->
        <div class="mt-4">
          <label for="assignmentDescription" class="block mb-2">Assignment Description</label>
          <textarea
            id="assignmentDescription"
            v-model="assignment.description"
            class="border rounded w-full px-3 py-2"
            rows="4"
          />
        </div>

        <!-- Submission Date -->
        <div class="mt-4">
          <label for="submissionDate" class="block mb-2">Submission Date</label>
          <input
            type="datetime-local"
            id="submissionDate"
            v-model="formattedSubmissionDate"
            :min="minDate"
            :max="maxDate"
            class="border rounded w-full px-3 py-2"
            required
          />
        </div>

        <!-- Exercises Section -->
        <div class="mt-6">
          <h4 class="text-lg font-semibold">Exercises</h4>
          <button
            type="button"
            class="mt-2 mb-4 bg-green-500 text-white px-3 py-2 rounded"
            @click="addExercise"
          >
            Add Exercise
          </button>

          <div v-for="(exercise, exerciseIndex) in exercises" :key="exerciseIndex" class="mb-4">
            <div class="border p-4 rounded mb-4">
              <label class="block mb-2">Exercise Name</label>
              <input
                type="text"
                v-model="exercise.name"
                class="border rounded w-full px-3 py-2"
                required
              />

              <label class="block mb-2 mt-4">Exercise Description</label>
              <textarea
                v-model="exercise.description"
                class="border rounded w-full px-3 py-2"
                rows="3"
              />

              <label class="block mb-2 mt-4">Has Body?</label>
              <input type="checkbox" v-model="exercise.haveBody" class="mr-2" />
              <span>{{ exercise.haveBody ? 'Yes' : 'No' }}</span>

              <!-- Classes Section -->
              <div class="mt-4">
                <h5 class="font-semibold">Classes</h5>
                <button
                  type="button"
                  class="mt-2 mb-2 bg-blue-500 text-white px-3 py-2 rounded"
                  @click="addClass(exerciseIndex)"
                >
                  Add Class
                </button>

                <div
                  v-for="(cls, classIndex) in exercise.classes"
                  :key="classIndex"
                  class="p-2 mb-2"
                >
                  <label class="block mb-1">Class Name</label>
                  <input
                    type="text"
                    v-model="cls.name"
                    class="border rounded w-full px-2 py-1"
                    required
                  />

                  <label class="block mb-1 mt-2">Class Description</label>
                  <input
                    type="text"
                    v-model="cls.description"
                    class="border rounded w-full px-2 py-1"
                  />

                  <!-- Methods Section -->
                  <div class="mt-2">
                    <h6 class="font-semibold">Methods</h6>
                    <button
                      type="button"
                      class="mt-1 mb-2 bg-purple-500 text-white px-2 py-1 rounded"
                      @click="addMethod(exerciseIndex, classIndex)"
                    >
                      Add Method
                    </button>

                    <div
                      v-for="(method, methodIndex) in cls.methods"
                      :key="methodIndex"
                      class="p-2 mb-1"
                    >
                      <label class="block mb-1">Method Name</label>
                      <input
                        type="text"
                        v-model="method.name"
                        class="border rounded w-full px-2 py-1"
                        required
                      />

                      <label class="block mb-1 mt-2">Method Type</label>
                      <input
                        type="text"
                        v-model="method.type"
                        class="border rounded w-full px-2 py-1"
                      />

                      <label class="block mb-1 mt-2">Method Description</label>
                      <textarea
                        v-model="method.description"
                        class="border rounded w-full px-2 py-1"
                        rows="2"
                      ></textarea>

                      <!-- Parameters Section -->
                      <div class="mt-2">
                        <h6 class="font-semibold">Parameters</h6>
                        <button
                          type="button"
                          class="mt-1 mb-2 bg-teal-500 text-white px-2 py-1 rounded"
                          @click="addParameter(exerciseIndex, classIndex, methodIndex)"
                        >
                          Add Parameter
                        </button>

                        <div
                          v-for="(param, paramIndex) in method.parameters"
                          :key="paramIndex"
                          class="p-2 mb-1"
                        >
                          <label class="block mb-1">Parameter Name</label>
                          <input
                            type="text"
                            v-model="param.name"
                            class="border rounded w-full px-2 py-1"
                            required
                          />

                          <label class="block mb-1 mt-2">Parameter Type</label>
                          <input
                            type="text"
                            v-model="param.type"
                            class="border rounded w-full px-2 py-1"
                          />

                          <label class="block mb-1 mt-2">Parameter Description</label>
                          <textarea
                            v-model="param.description"
                            class="border rounded w-full px-2 py-1"
                            rows="2"
                          ></textarea>
                        </div>
                      </div>

                      <!-- Variables Section -->
                      <div class="mt-2">
                        <h6 class="font-semibold">Variables</h6>
                        <button
                          type="button"
                          class="mt-1 mb-2 bg-orange-500 text-white px-2 py-1 rounded"
                          @click="addVariable(exerciseIndex, classIndex, methodIndex)"
                        >
                          Add Variable
                        </button>

                        <div
                          v-for="(variable, varIndex) in method.variables"
                          :key="varIndex"
                          class="p-2 mb-1"
                        >
                          <label class="block mb-1">Variable Name</label>
                          <input
                            type="text"
                            v-model="variable.name"
                            class="border rounded w-full px-2 py-1"
                            required
                          />

                          <label class="block mb-1 mt-2">Variable Type</label>
                          <input
                            type="text"
                            v-model="variable.type"
                            class="border rounded w-full px-2 py-1"
                          />
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <button
          type="submit"
          :disabled="isSubmitting"
          :class="[
            'mt-4 block w-full rounded p-3 text-white',
            isSubmitting ? 'bg-blue-300 cursor-not-allowed' : 'bg-blue-500 hover:bg-blue-600'
          ]"
        >
          {{ isSubmitting ? 'Creating...' : 'Create Assignment' }}
        </button>
      </form>
    </template>
  </ModalLayout>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import ModalLayout from '@/layouts/ModalLayout.vue'
import type { Assignment, Exercise, Class, Method } from '@/types/Assigment'
import AssignmentService from '@/services/AssigmentService'
import Swal from 'sweetalert2'
import { useAssignmentStore } from '@/stores/assigmentStore'

const props = defineProps({
  modalOpen: Boolean,
  courseId: String
})

const emit = defineEmits(['close'])
const assignmentStore = useAssignmentStore()

const isSubmitting = ref(false)
const errorMessage = ref('')
const formattedSubmissionDate = ref('')

const minDate = computed(() => {
  const now = new Date()
  now.setMinutes(now.getMinutes() - now.getTimezoneOffset())
  return now.toISOString().slice(0, 16)
})

const maxDate = computed(() => {
  const now = new Date()
  now.setFullYear(now.getFullYear() + 2)
  return now.toISOString().slice(0, 16)
})

const assignment = ref<Assignment>({
  id: '',
  title: '',
  description: '',
  submissionDate: '',
  courseId: props.courseId
})

const exercises = ref<Exercise[]>([])

const handleClose = () => {
  emit('close')
  assignment.value = {
    id: '',
    title: '',
    description: '',
    submissionDate: '',
    courseId: props.courseId
  }
  exercises.value = []
  formattedSubmissionDate.value = ''
}

const handleSubmit = async () => {
  try {
    isSubmitting.value = true
    const localDate = new Date(formattedSubmissionDate.value)
    assignment.value.submissionDate = localDate.toISOString()
    assignment.value.exercises = exercises.value

    const createdAssignment = await AssignmentService.createAssignment(assignment.value)
    console.log('Assignment Created:', assignment.value)

    assignment.value = {
      id: '',
      title: '',
      description: '',
      submissionDate: '',
      courseId: props.courseId
    }
    exercises.value = []
    formattedSubmissionDate.value = ''

    handleClose()

    Swal.fire({
      title: 'Assignment Created!',
      text: 'The assignment has been created successfully.',
      icon: 'success',
      confirmButtonText: 'Ok'
    })
    await assignmentStore.fetchAssignmentsByCourse(props.courseId)
  } catch (error: any) {
    console.error('Error creating assignment:', error)
    handleClose()
    if (error.response && error.response.status === 409) {
      errorMessage.value = 'There is already a course with the same name'
    } else {
      // Si es cualquier otro error, mostrar un mensaje genérico
      errorMessage.value = 'An unexpected error occurred. Please try again later.'
    }

    Swal.fire({
      title: 'Assignment Creation Failed',
      text: errorMessage.value,
      icon: 'error',
      confirmButtonText: 'Try Again'
    })
  } finally {
    isSubmitting.value = false // Habilita el botón nuevamente
  }
}

const addExercise = () => {
  exercises.value.push({
    name: '',
    description: '',
    haveBody: false,
    classes: []
  })
}

const addClass = (exerciseIndex: number) => {
  exercises.value[exerciseIndex].classes.push({
    name: '',
    description: '',
    methods: []
  })
}

const addMethod = (exerciseIndex: number, classIndex: number) => {
  exercises.value[exerciseIndex].classes[classIndex].methods.push({
    name: '',
    type: '',
    description: '',
    parameters: [],
    variables: []
  })
}

const addParameter = (exerciseIndex: number, classIndex: number, methodIndex: number) => {
  exercises.value[exerciseIndex].classes[classIndex].methods[methodIndex].parameters.push({
    name: '',
    type: '',
    description: ''
  })
}

const addVariable = (exerciseIndex: number, classIndex: number, methodIndex: number) => {
  exercises.value[exerciseIndex].classes[classIndex].methods[methodIndex].variables.push({
    name: '',
    type: ''
  })
}
</script>

<style scoped>
/* Estilos opcionales adicionales */
</style>
