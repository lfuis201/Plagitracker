// src/schemas/teacherSchema.ts
import { z } from 'zod';

// Crear el esquema de validación para Teacher
export const TeacherSchema = z.object({
  id: z.string().optional(), // El id es opcional
  firstName: z.string().min(1, { message: "First name is required" }), // Requerido y mínimo de 1 caracter
  lastName: z.string().min(1, { message: "Last name is required" }), // Requerido y mínimo de 1 caracter
  email: z.string().email({ message: "Invalid email address" }), // Validación de email
  passwordHash: z.string().min(8, { message: "Password must be at least 8 characters long" }) // Requerido con mínimo de 8 caracteres
});
