// Import the Course interface
import type { Course } from "./Course";

export interface Parameter {
  name: string;
  type: string;
  description: string;
}

export interface Variable {
  name: string;
  type: string;
}

export interface Method {
  name: string;
  type: string;
  description: string;
  parameters: Parameter[];
  variables: Variable[];
}

export interface Class {
  name: string;
  description: string;
  childClasses: string[];
  methods: Method[];
}

export interface Exercise {
  name?: string;
  description?: string;
  haveBody?: boolean;
  classes?: Class[];
}

export interface Assignment {
  id: string;
  description?: string;
  title: string;
  submissionDate: Date;
  courseId: string;
  course?: Course;
  submitted?: boolean;
  exercises: Exercise[];
}
