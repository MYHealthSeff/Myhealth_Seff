const connect = require('../config/rabbitmq');

const publishPatientUpdate = async (patient) => {
  const { channel } = await connect();
  const message = JSON.stringify(patient);
  channel.sendToQueue('patient_updates', Buffer.from(message));
};

module.exports = publishPatientUpdate;
