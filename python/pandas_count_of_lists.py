import pandas as pd


def data_banner():
    print(f'{20 * "*"}')


if __name__ == '__main__':
    animal_list = ["Baboon", "Spider", "Spider", "Baboon", "Cobra",
                   "Baboon", "Baboon", "Spider", "Leopard", "Leopard",
                   "Elephant", "Baboon", "Spider", "Leopard", "Leopard",
                   ]

    animal_df = pd.DataFrame(animal_list)
    data_banner()
    print(animal_df.info())

    # Print all the list
    data_banner()
    print(animal_df)

    # By lowest to highest count
    data_banner()
    print(animal_df.value_counts(ascending=True))

    # By alphabetical order and then count
    data_banner()
    print(animal_df.value_counts().sort_index(ascending=True))

    # percentage view
    data_banner()
    print(animal_df.value_counts(normalize=True))

    # Only show Animals where count is greater than 3
    print(animal_df.value_counts().loc[lambda x: x > 3])

    # Sort and op take top three rows
    print(animal_df.value_counts(ascending=True).head(3))
