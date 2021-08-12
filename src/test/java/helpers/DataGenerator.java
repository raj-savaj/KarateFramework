package helpers;

import com.github.javafaker.Faker;

public class DataGenerator {
    public static String getRandomSupplierName() {
        Faker faker = new Faker();
        String name=faker.name().firstName();
        return name;
    }
}
