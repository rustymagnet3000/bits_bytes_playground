import pandas as pd


def data_banner():
    print(f'{20 * "*"}')


if __name__ == '__main__':
    animal_list = ["Baboon", "Spider", "Spider", "Baboon", "Cobra",
                   "Baboon", "Baboon", "Spider", "Leopard", "Leopard",
                   "Elephant", "Baboon", "Spider", "Leopard", "Leopard",
                   ]

    animal_df = pd.DataFrame(animal_list)

    # Count values
    animal_df.count()

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
    data_banner()
    print(animal_df.value_counts().loc[lambda x: x > 3])

    # Sort and op take top three rows
    data_banner()
    print(animal_df.value_counts(ascending=True).head(3))

    # Print column types
    animal_df.dtypes

    # Cast epoch string to (positive) integer
    pd.to_numeric(animal_df['createDate'], downcast='unsigned')
    0    1626601314001
    1    1626303600001
    2    1626303600001
    3    1626303600001
    4    1626601314000
    Name: createDate, dtype: uint64

    # Persist cast of column type
    items_df['createDate']=items_df['createDate'].astype(int)
    items_df.dtypes
    name               object
    createDate       int64

    # Change Epoch Int value to Date
    items_df['Created_Date'] = pd.to_datetime(items_df['createDate'], unit='s')

    # Create a Time Delta
    items_df['sessionDuration'] = items_df['prettyExpiryDate'].sub(items_df['prettyCreationDate'])
    items_df['sessionDuration'].values


# ********************
# <class 'pandas.core.frame.DataFrame'>
# RangeIndex: 15 entries, 0 to 14
# Data columns (total 1 columns):
#  #   Column  Non-Null Count  Dtype
# ---  ------  --------------  -----
#  0   0       15 non-null     object
# dtypes: object(1)
# memory usage: 248.0+ bytes
# None
# ********************
#            0
# 0     Baboon
# 1     Spider
# 2     Spider
# 3     Baboon
# 4      Cobra
# 5     Baboon
# 6     Baboon
# 7     Spider
# 8    Leopard
# 9    Leopard
# 10  Elephant
# 11    Baboon
# 12    Spider
# 13   Leopard
# 14   Leopard
# ********************
# Cobra       1
# Elephant    1
# Leopard     4
# Spider      4
# Baboon      5
# dtype: int64
# ********************
# Baboon      5
# Cobra       1
# Elephant    1
# Leopard     4
# Spider      4
# dtype: int64
# ********************
# Baboon      0.333333
# Leopard     0.266667
# Spider      0.266667
# Cobra       0.066667
# Elephant    0.066667
# dtype: float64
# ********************
# Baboon     5
# Leopard    4
# Spider     4
# dtype: int64
# ********************
# Cobra       1
# Elephant    1
# Leopard     4
# dtype: int64