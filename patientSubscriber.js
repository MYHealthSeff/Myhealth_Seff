const connect = require('../config/rabbitmq');
const Patient = require('../models/patient');

const subscribeToPatientUpdates = async () => {
  const { channel } = await connect();
  channel.consume('patient_updates', async (msg) => {
    const patient = JSON.parse(msg.content.toString());
   
    await Patient.upsert(patient);
    channel.ack(msg);
  });
};

module.exports = subscribeToPatientUpdates;
