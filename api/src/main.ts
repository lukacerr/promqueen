// * Base imports
import express from 'express';
import dotenv from 'dotenv';
import mongoose from 'mongoose';
import { ConnectionOptions } from 'tls';

// * Common imports
import { ErrorHandler } from 'common/sender';

// * Router imports
import baseRoute from 'routes/baseRouter';
import intakeRoute from 'routes/intakeRouter';

// * DOTENV init
dotenv.config();

// * Middlewares & Express init
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// * Routes middlewares
app.use('/', baseRoute);
app.use('/intake', intakeRoute);

// * 404 (not found) middleware/handler
app.use(async (req, res) => {
  await ErrorHandler(req, res, `Path '${req.originalUrl}' (${req.method}) not found`, 404);
});

// ! App start
mongoose
  .connect(
    `${process.env.CONNECTION_STRING}/${process.env.SELECTED_DB}?retryWrites=true&w=majority`,
    { useNewUrlParser: true } as ConnectionOptions,
  )
  .then(() => app.listen(Number(process.env.PORT), '0.0.0.0', () => {
    console.clear();
    console.log(`Server started on "http://localhost:${process.env.PORT}/".`);
    console.log(`Aiming to database "${process.env.SELECTED_DB}".`);
  })).catch((e) => console.error(e));
