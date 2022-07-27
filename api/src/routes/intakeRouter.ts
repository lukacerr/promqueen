// * Base imports
import express from 'express';

// * Controller import
import * as Controller from 'controllers/intakeController';

// * Router init
const router = express.Router();

// * Methods init
router.get('/get', Controller.GetAll);
router.get('/get/:id', Controller.Get);
router.post('/create', Controller.Create);
router.delete('/delete', Controller.DeleteAll);
router.delete('/delete/:id', Controller.Delete);
router.put('/edit/:id', Controller.Edit);

// ! Route export
export default router;
