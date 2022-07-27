// * Base imports
import { model, Schema, Document } from 'mongoose';

// * Collection name definition
const name = 'intakes';

// * Interface definition
interface IBase extends Document {
  deviceId: string;
  operativeSystem: string;
  deviceInfo: string;
  calorieIntake: number;
  proteinIntake: number;
  carbsIntake: number;
  fatsIntake: number;
  sodiumIntake: number;
  bodyWeight: number;
  bodyFat: number;
  startDate: Date;
}

// * Schema definition
const schema: Schema = new Schema(
  {
    deviceId: String,
    operativeSystem: { type: String, default: '-' },
    deviceInfo: { type: String, default: '-' },
    calorieIntake: { type: Number, default: 2000 },
    proteinIntake: { type: Number, default: 100 },
    carbsIntake: { type: Number, default: 200 },
    fatsIntake: { type: Number, default: 50 },
    sodiumIntake: { type: Number, default: 1200 },
    bodyWeight: { type: Number, default: 70 },
    bodyFat: { type: Number, default: 20 },
    startDate: { type: Date, default: Date.now },
  },
  { collection: name },
);

// ! Model export
export default model<IBase>(name, schema);
