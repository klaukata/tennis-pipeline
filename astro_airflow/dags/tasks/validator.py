"""
Module for validating and parsing player data from a CSV file, using Pydantic to enforce strict data validation rules.
"""

from pydantic import (
    BaseModel, 
    StringConstraints,
    field_validator,
    NonNegativeInt,
    PositiveInt,
    NonNegativeFloat,
)
from typing import Union
from typing_extensions import Annotated
import pandas as pd

class Player(BaseModel):
    index: NonNegativeInt
    Rank: PositiveInt
    Name: Annotated[    #  name == capitalized first word followed by one or more capitalized words, each separated by a single space
        str,
        StringConstraints(
            pattern=r"^[A-Z]{1}[a-z]+(\s[A-Z]{1}[A-Za-z]*)+$",
            strip_whitespace=True
        )
    ]
    Pts: NonNegativeFloat
    Tourn_P: NonNegativeFloat
    Rank_P: NonNegativeFloat
    Ach_P: NonNegativeFloat
    GS: NonNegativeInt
    TF: NonNegativeInt
    AF: NonNegativeInt
    M: NonNegativeInt
    O: Union[   # o >= 0 || o == "-" 
        NonNegativeInt, 
        Annotated[
            str,
            StringConstraints(pattern=r"[-]")
        ]
    ]
    BT: NonNegativeInt
    T: NonNegativeInt
    W_at_1: NonNegativeInt
    W_Proc: str
    Elo: PositiveInt

    @field_validator("W_Proc")
    def has_proper_form(cls, v):
        if v[-1:] != "%":
            raise ValueError(f"There is no % symbol present at the end of this string: {v}")
        v_list = v[:-1].split('.')
        whole = int(v_list[0])
        tenths = int(v_list[1])
        
        if whole not in range(101):
            raise ValueError(f"The percentage value in {v} must be between 0 and 100, inclusive.")
        if tenths not in range(10):
            raise ValueError(f"The decimal part (.{tenths}) of the percentage {v} must contain exactly one non-negative digit.")
        if whole == 100 and tenths != 0:
            raise ValueError(f"The decimal part (.{tenths}) of percentage equal to {v} can only be 0.")
        return v


def parse_and_validate(players: dict):
    for player in players:
        Player(**player)
    print("The data validation process was successful.")


def validator(csv_path: str):
    column_names_to_rename = {
        "Unnamed: 0": "index",
        "Tourn P": "Tourn_P",
        "Rank P": "Rank_P",
        "Ach P": "Ach_P",
        "W@1": "W_at_1",
        "W%": "W_Proc"
    }
    try:
        df = pd.read_csv(csv_path).rename(columns=column_names_to_rename)
        dict = df.to_dict('records')
        return parse_and_validate(dict)
    except OSError as e:
        raise OSError(f"Failed to perform operations on {csv_path} because of exception: {e}")
    except ValueError as e:
        raise ValueError(e)
