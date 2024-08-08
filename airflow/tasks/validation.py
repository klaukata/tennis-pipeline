from pydantic import BaseModel, Field

class Player(BaseModel):
    Rank: int
    Name: str
    Pts: int
    Tourn_P: int = Field(alias="Tourn P")
    Rank_P: int = Field(alias="Rank P")
    Ach_P: int = Field(alias="Ach P")
    GS: int
    TF: int
    AF: int
    M: int
    O:  str
    BT: int
    T: int
    W_1: int = Field(alias="W@1")
    W_pct: str = Field(alias="W%")
    Elo: int