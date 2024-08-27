const express = require('express');
const Patient = require('../models/patient');
const router = express.Router();

router.get('/', async (req, res) => {
  const patients = await Patient.findAll();
  res.json(patients);
});

router.post('/', async (req, res) => {
  const patient = await Patient.create(req.body);
  res.json(patient);
});

router.put('/:id', async (req, res) => {
  await Patient.update(req.body, { where: { id: req.params.id } });
  res.sendStatus(200);
});

router.delete('/:id', async (req, res) => {
  await Patient.destroy({ where: { id: req.params.id } });
  res.sendStatus(200);
});

module.exports = router;
