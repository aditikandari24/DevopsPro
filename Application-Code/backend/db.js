const mongoose = require("mongoose");

module.exports = async () => {
    try {
        const connectionParams = {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        };
        
        // Ensure the MongoDB connection string is set
        const mongoConnStr = process.env.MONGO_CONN_STR;
        if (!mongoConnStr) {
            throw new Error('MongoDB connection string (MONGO_CONN_STR) is not defined in the environment variables.');
        }

        // Check if database authentication is required
        const useDBAuth = process.env.USE_DB_AUTH === 'true'; // 'true' as string for env comparison
        if (useDBAuth) {
            if (!process.env.MONGO_USERNAME || !process.env.MONGO_PASSWORD) {
                throw new Error('Database authentication is enabled, but MONGO_USERNAME or MONGO_PASSWORD is missing.');
            }
            connectionParams.user = process.env.MONGO_USERNAME;
            connectionParams.pass = process.env.MONGO_PASSWORD;
        }

        // Connect to MongoDB using the connection string from environment variables
        await mongoose.connect(mongoConnStr, connectionParams);
        
        console.log("Successfully connected to the database.");
    } catch (error) {
        console.error("Database connection failed.", error.message);
        process.exit(1);  // Exit the application if database connection fails
    }
};
