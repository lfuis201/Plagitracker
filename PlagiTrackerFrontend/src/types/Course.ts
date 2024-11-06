export interface Course {
  id: string;         // String equivalente a Guid
  name: string;       // String con validación de longitud
  teacherId: string;  // String equivalente a Guid
  isArchived: boolean; // Booleano que indica si el curso está archivado
  isEnabled: boolean;  // Booleano que indica si el curso está habilitado
}
