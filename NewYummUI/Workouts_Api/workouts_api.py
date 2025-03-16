from fastapi import FastAPI, HTTPException
from typing import List
from pydantic import BaseModel

app = FastAPI()

# Workout Model
class Workout(BaseModel):
    id: int
    name: str
    category: str  # e.g., Strength, Cardio
    duration: int  # in minutes
    difficulty: str  # Easy, Medium, Hard

# In-memory database (Replace with a real database)
workouts_db = [
    {"id": 1, "name": "Push-Ups", "category": "Strength", "duration": 10, "difficulty": "Medium"},
    {"id": 2, "name": "Running", "category": "Cardio", "duration": 30, "difficulty": "Hard"},
]

# 1️⃣ Get all workouts
@app.get("/workouts", response_model=List[Workout])
def get_workouts():
    return workouts_db

# 2️⃣ Get a specific workout by ID
@app.get("/workout/{workout_id}", response_model=Workout)
def get_workout(workout_id: int):
    for workout in workouts_db:
        if workout["id"] == workout_id:
            return workout
    raise HTTPException(status_code=404, detail="Workout not found")

# 3️⃣ Add a new workout
@app.post("/workout", response_model=Workout)
def add_workout(workout: Workout):
    workouts_db.append(workout.dict())
    return workout

# 4️⃣ Update an existing workout
@app.put("/workout/{workout_id}", response_model=Workout)
def update_workout(workout_id: int, updated_workout: Workout):
    for i, workout in enumerate(workouts_db):
        if workout["id"] == workout_id:
            workouts_db[i] = updated_workout.dict()
            return updated_workout
    raise HTTPException(status_code=404, detail="Workout not found")

# 5️⃣ Delete a workout
@app.delete("/workout/{workout_id}")
def delete_workout(workout_id: int):
    for i, workout in enumerate(workouts_db):
        if workout["id"] == workout_id:
            del workouts_db[i]
            return {"message": "Workout deleted"}
    raise HTTPException(status_code=404, detail="Workout not found")

# Run the API
if __name__ == "__main__":
    import uvicorn
    # uvicorn.run(app, host="0.0.0.0", port=8000)
    uvicorn.run(app, host="myworkoutapi.local", port=8000)
     
