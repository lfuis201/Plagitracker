import type { Assignment } from './Assigment'
import type { Student } from './Student'

export interface Submission {
  id: string

  url: string

  submissionDate: Date

  studentId: string

  assignmentId: string

  student?: Student

  assignment?: Assignment
}