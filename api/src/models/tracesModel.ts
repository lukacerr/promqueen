// * Base imports
import { model, Schema, Document } from 'mongoose';

// * Collection name definition
const name = 'traces';

// * Interface definition
interface IBase extends Document {
  log: unknown;
  date: Date;
  code: number;
  path: string;
  method: string;
  deviceId?: string;
}

// * Schema definition
const schema: Schema = new Schema(
  {
    log: Schema.Types.Mixed,
    date: Date,
    code: Number,
    path: String,
    method: String,
    strDate: String,
    deviceId: String,
  },
  { collection: name },
);

// ! Model export
export default model<IBase>(name, schema);
