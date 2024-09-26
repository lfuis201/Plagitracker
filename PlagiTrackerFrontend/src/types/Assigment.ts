import type { Course } from "./Course";

export interface Assignment {
    id: string;
    description?: string;
    title: string;
    submissionDate: Date;
    courseId: string;
    course?: Course;
  }
  