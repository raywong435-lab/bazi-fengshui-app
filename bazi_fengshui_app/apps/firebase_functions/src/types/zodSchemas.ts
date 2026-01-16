import { z } from 'zod';

// Birth info schema for input validation
export const birthInfoSchema = z.object({
  name: z.string(),
  birthDate: z.string(), // ISO date string
  birthTime: z.string(), // HH:MM format
  gender: z.enum(['male', 'female']),
  location: z.string(), // city or coordinates
});