// * Base imports
import { Request, Response } from 'express';

// * Common imports
import { Execute } from 'common/sender';

// * Model imports
import Intake from 'models/intakesModel';

// * /intake/get (GET)
export const GetAll = async (req: Request, res: Response) => {
  await Execute(req, res, async () => ({
    value: await Intake.find({ deviceId: req.header('Device-Id') }),
    code: 200,
  }));
};

// * /intake/get/:id (GET)
export const Get = async (req: Request, res: Response) => {
  await Execute(req, res, async () => ({
    value: await Intake.findById(req.params.id),
    code: 200,
  }));
};

// * /intake/create (POST)
export const Create = async (req: Request, res: Response) => {
  await Execute(req, res, async () => ({
    value: await Intake.create({ ...req.body, deviceId: req.header('Device-Id') }),
    code: 201,
  }));
};

// * /intake/delete (DELETE)
export const DeleteAll = async (req: Request, res: Response) => {
  await Execute(req, res, async () => ({
    value: await Intake.deleteMany({ deviceId: req.header('Device-Id') }),
    code: 204,
  }));
};

// * /intake/delete/:id (DELETE)
export const Delete = async (req: Request, res: Response) => {
  await Execute(req, res, async () => ({
    value: await Intake.findByIdAndDelete(req.params.id),
    code: 204,
  }));
};

// * /intake/edit/:id (PUT)
export const Edit = async (req: Request, res: Response) => {
  await Execute(req, res, async () => ({
    value: await Intake.findByIdAndUpdate(req.params.id, { ...req.body }, { new: true }),
    code: 200,
  }));
};
