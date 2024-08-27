const amqp = require('amqplib');

const connect = async () => {
  const connection = await amqp.connect('amqp://localhost');
  const channel = await connection.createChannel();
  await channel.assertQueue('patient_updates');
  return { connection, channel };
};

module.exports = connect;
