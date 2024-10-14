// src/schemas/studentSchema.ts
import { z } from 'zod'

// Crear el esquema de validación para Student
export const StudentSchema = z.object({
  id: z.string().optional(), // El id es opcional
  firstName: z.string().min(1, { message: 'First name is required' }), // Requerido y mínimo de 1 carácter
  lastName: z.string().min(1, { message: 'Last name is required' }), // Requerido y mínimo de 1 carácter
  email: z
    .string()
    .email({ message: 'Invalid email address' }) // Validación de email
    // Restricción para permitir un máximo de dos extensiones de dominio concatenadas
    .regex(/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(?:\.[a-zA-Z]{2,})?$/, {
      message: 'Email must not have more than two domain extensions'
    }),
  passwordHash: z
    .string()
    .min(8, { message: 'Password must be at least 8 characters long' }) // Mínimo de 8 caracteres
    .max(30, { message: 'Password must not exceed 30 characters' }) // Máximo de 30 caracteres
})

// Puedes usar el esquema para validar un objeto Student así:
export const validateStudent = (data: unknown) => {
  return StudentSchema.parse(data)
}
