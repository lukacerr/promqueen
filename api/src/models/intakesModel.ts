// * Base imports
import { model, Schema, Document } from 'mongoose';

// * Collection name definition
const name = 'intakes';

// * Interface definition
interface IBase extends Document {
  userId: string;
  name: string;
  calories: number;
  protein: number;
  carbs: number;
  fats: number;
  sodium: number;
  alreadyAte: boolean;
  loadDate: Date;
  editDate: Date;
}

// * Schema definition
const schema: Schema = new Schema(
  {
    deviceId: String,
    name: { type: String, default: '-' },
    calories: { type: Number, default: 0 },
    protein: { type: Number, default: 0 },
    carbs: { type: Number, default: 0 },
    fats: { type: Number, default: 0 },
    sodium: { type: Number, default: 0 },
    alreadyAte: { type: Boolean, default: true },
    loadDate: { type: Date, default: Date.now },
    editDate: { type: Date, default: Date.now },
  },
  { collection: name },
);

// ! Model export
export default model<IBase>(name, schema);
