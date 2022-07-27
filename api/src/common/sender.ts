// * Base imports
import { Request, Response } from 'express';

// * Model imports
import Trace from 'models/tracesModel';

// ! Success handling
export const SuccessHandler = (res: Response, data: unknown, code: number) => {
  console.log('\x1b[32m%s\x1b[0m', 'RETURNING:', JSON.stringify(data));
  res.status(code).json({ error: false, content: data });
};

// ! Error handling
export const ErrorHandler = async (req: Request, res: Response, e: unknown, code: number, valError?: boolean) => {
  res.status(code);

  try {
    if (!valError) {
      await new Trace({
        log: e,
        date: new Date(),
        code,
        path: req.originalUrl,
        method: req.method,
        deviceId: req.header('device'),
      }).save();
    }

    console.error('\x1b[31m%s\x1b[0m', `[${code}] ERROR:`, `${(e as Error)?.stack ?? e}`);

    return res.json({
      error: true,
      content: (e as Error)?.message ?? e,
    });
  } catch (e2: unknown) {
    console.error('\x1b[31m%s\x1b[0m', `DATABASE ERROR: ${(e2 as Error)?.stack ?? e2}`);
    return res.json({ error: true, content: { initial_error: e, db_error: e2 } });
  }
};

// ! Default method
export const Execute = async (req: Request, res: Response, func: () => Promise<{ value: unknown; code: number }>) => {
  try {
    await func().then((data) => {
      SuccessHandler(res, data.value, data.code);
    });
  } catch (e: unknown) {
    const val = Boolean((e as { name: string }).name === 'ValidationError');
    await ErrorHandler(req, res, e, val ? 400 : 500, val);
  }
};
