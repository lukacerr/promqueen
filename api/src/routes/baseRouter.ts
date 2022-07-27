// * Base imports
import express from 'express';

// * Controller import
import * as Controller from 'controllers/baseController';

// * Router init
const router = express.Router();

// * Methods init
router.get('/test', Controller.GetTest);
router.post('/test', Controller.PostTest);
router.get('/error', Controller.Error);

// ! Route export
export default router;
