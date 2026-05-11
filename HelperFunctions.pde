int calculateBMR(User user) {
        if (user.sex.equals(male)){
            return (10 * user.weight) + (6.25 * user.userHeight) - (5 * user.age) + 5;
        }
        else if (user.sex.equals(female)){
            return (10 * user.weight) + (6.25 * user.userHeight) - (5 * user.age) - 161;
        }
    }