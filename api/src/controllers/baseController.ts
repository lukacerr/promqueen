// * Base imports
import { Request, Response } from 'express';

// * Common imports
import { ErrorHandler, Execute } from 'common/sender';

// * /test (GET)
export const GetTest = async (req: Request, res: Response) => {
  await Execute(req, res, async () => ({ value: 'GET method returned response successfully!', code: 200 }));
};

// * /test (POST)
export const PostTest = async (req: Request, res: Response) => {
  await Execute(req, res, async () => ({ value: 'POST method returned response successfully!', code: 200 }));
};

// * /error (GET)
export const Error = async (req: Request, res: Response) => {
  await ErrorHandler(req, res, 'Forced error response.', 500);
};
