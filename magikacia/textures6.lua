magikacia.textures = magikacia.textures or {}
local textures = {
    firefly_green = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAFpJREFUOE9jZKAQMFKon2E4G/D//38D5PBhZGS8gC28sIYBTLN9jstskKaDU/akgmhshuA0AKRZLFjSBKTx1drnZ0CG0NcAkM1kewGkmaJAJCV1DueUSGw4AAC4BzARPbvQuwAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    firefly_purple = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAFpJREFUOE9jZKAQMFKon2E4G/D//38D5PBhZGS8gC28sIYBTHOkfdhskKblB1elgmhshuA0AKTZQtTMBKTxxOtTZ0CG0NcAkM1kewGkmaJAJCV1DueUSGw4AAC35zARyhHv2QAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    firefly_blue = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAFpJREFUOE9jZKAQMFKon2E4G/D//38D5PBhZGS8gC28sIYBTLODf9xskKYDGxelgmhshuA0AKRZUsfeBKTx+ZWDZ0CG0NcAkM1kewGkmaJAJCV1DueUSGw4AAC3xzARtWqbWQAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    effect_absolute_solver_primary = "iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAACXBIWXMAAAsRAAALEQF/ZF+RAAABv3RFWHRSYXcgcHJvZmlsZSB0eXBlIGV4aWYACmV4aWYKICAgICAyMDIKNDU3ODY5NjYwMDAwNDk0OTJhMDAwODAwMDAwMDA3MDAxMjAxMDMwMDAxMDAwMDAwMDEwMDAwMDAxYTAxMDUwMDAxMDAwMDAwCjYyMDAwMDAwMWIwMTA1MDAwMTAwMDAwMDZhMDAwMDAwMjgwMTAzMDAwMTAwMDAwMDAyMDAwMDAwMzEwMTAyMDAyNzAwMDAwMAo3MjAwMDAwMDMyMDEwMjAwMDAwMDAwMDAwMDAwMDAwMDY5ODcwNDAwMDEwMDAwMDA5YTAwMDAwMDAwMDAwMDAwYTkwMzAwMDAKNjQwMDAwMDBhOTAzMDAwMDY0MDAwMDAwNDE2NDZmNjI2NTIwNTA2ODZmNzQ2ZjczNjg2ZjcwMjA0NTZjNjU2ZDY1NmU3NDczCjIwMzEzNDJlMzAyMDI4NTc2OTZlNjQ2Zjc3NzMyOTAwMDMwMDAxYTAwMzAwMDEwMDAwMDAwMTAwMDAwMDAyYTAwNDAwMDEwMAowMDAwZWUwMjAwMDAwM2EwMDQwMDAxMDAwMDAwODcwMjAwMDAwMDAwMDAwMAphZraWAAAAWnRFWHRSYXcgcHJvZmlsZSB0eXBlIGlwdGMACmlwdGMKICAgICAgMjYKNTA2ODZmNzQ2ZjczNjg2ZjcwMjAzMzJlMzAwMDM4NDI0OTRkMDQwNDAwMDAwMDAwMDAwMArH0WncAAAgjXRFWHRSYXcgcHJvZmlsZSB0eXBlIHhtcAAKeG1wCiAgICA0MDkyCjNjM2Y3ODcwNjE2MzZiNjU3NDIwNjI2NTY3Njk2ZTNkMjJlZmJiYmYyMjIwNjk2NDNkMjI1NzM1NGQzMDRkNzA0MzY1Njg2OQo0ODdhNzI2NTUzN2E0ZTU0NjM3YTZiNjMzOTY0MjIzZjNlMGEzYzc4M2E3ODZkNzA2ZDY1NzQ2MTIwNzg2ZDZjNmU3MzNhNzgKM2QyMjYxNjQ2ZjYyNjUzYTZlNzMzYTZkNjU3NDYxMmYyMjIwNzgzYTc4NmQ3MDc0NmIzZDIyNTg0ZDUwMjA0MzZmNzI2NTIwCjM0MmUzNDJlMzAyZDQ1Nzg2OTc2MzIyMjNlMGEyMDNjNzI2NDY2M2E1MjQ0NDYyMDc4NmQ2YzZlNzMzYTcyNjQ2NjNkMjI2OAo3NDc0NzAzYTJmMmY3Nzc3NzcyZTc3MzMyZTZmNzI2NzJmMzEzOTM5MzkyZjMwMzIyZjMyMzIyZDcyNjQ2NjJkNzM3OTZlNzQKNjE3ODJkNmU3MzIzMjIzZTBhMjAyMDNjNzI2NDY2M2E0NDY1NzM2MzcyNjk3MDc0Njk2ZjZlMjA3MjY0NjYzYTYxNjI2Zjc1Cjc0M2QyMjIyMGEyMDIwMjAyMDc4NmQ2YzZlNzMzYTc0Njk2NjY2M2QyMjY4NzQ3NDcwM2EyZjJmNmU3MzJlNjE2NDZmNjI2NQoyZTYzNmY2ZDJmNzQ2OTY2NjYyZjMxMmUzMDJmMjIwYTIwMjAyMDIwNzg2ZDZjNmU3MzNhNzA2ODZmNzQ2ZjczNjg2ZjcwM2QKMjI2ODc0NzQ3MDNhMmYyZjZlNzMyZTYxNjQ2ZjYyNjUyZTYzNmY2ZDJmNzA2ODZmNzQ2ZjczNjg2ZjcwMmYzMTJlMzAyZjIyCjBhMjAyMDIwMjA3ODZkNmM2ZTczM2E2NDYzM2QyMjY4NzQ3NDcwM2EyZjJmNzA3NTcyNmMyZTZmNzI2NzJmNjQ2MzJmNjU2Ywo2NTZkNjU2ZTc0NzMyZjMxMmUzMTJmMjIwYTIwMjAyMDIwNzg2ZDZjNmU3MzNhNzg2ZDcwNGQ0ZDNkMjI2ODc0NzQ3MDNhMmYKMmY2ZTczMmU2MTY0NmY2MjY1MmU2MzZmNmQyZjc4NjE3MDJmMzEyZTMwMmY2ZDZkMmYyMjBhMjAyMDIwMjA3ODZkNmM2ZTczCjNhNzM3NDQ1NzY3NDNkMjI2ODc0NzQ3MDNhMmYyZjZlNzMyZTYxNjQ2ZjYyNjUyZTYzNmY2ZDJmNzg2MTcwMmYzMTJlMzAyZgo3MzU0Nzk3MDY1MmY1MjY1NzM2Zjc1NzI2MzY1NDU3NjY1NmU3NDIzMGEyZjIyMGEyMDIwMjAyMDc4NmQ2YzZlNzMzYTY1NzgKNjk2NjNkMjI2ODc0NzQ3MDNhMmYyZjZlNzMyZTYxNjQ2ZjYyNjUyZTYzNmY2ZDJmNjU3ODY5NjYyZjMxMmUzMDJmMjIwYTIwCjIwMjAyMDc4NmQ2YzZlNzMzYTc4NmQ3MDNkMjI2ODc0NzQ3MDNhMmYyZjZlNzMyZTYxNjQ2ZjYyNjUyZTYzNmY2ZDJmNzg2MQo3MDJmMzEyZTMwMmYyMjBhMjAyMDIwNzQ2OTY2NjYzYTUyNjU3MzZmNmM3NTc0Njk2ZjZlNTU2ZTY5NzQzZDIyMzIyMjBhMjAKMjAyMDc0Njk2NjY2M2E0ZjcyNjk2NTZlNzQ2MTc0Njk2ZjZlM2QyMjMxMjIwYTIwMjAyMDc0Njk2NjY2M2E1ODUyNjU3MzZmCjZjNzU3NDY5NmY2ZTNkMjIzOTMzMzcyMDJmMjAzMTMwMzAyMjBhMjAyMDIwNzQ2OTY2NjYzYTU5NTI2NTczNmY2Yzc1NzQ2OQo2ZjZlM2QyMjM5MzMzNzIwMmYyMDMxMzAzMDIyMGEyMDIwMjA3MDY4NmY3NDZmNzM2ODZmNzAzYTQ5NDM0MzUwNzI2ZjY2NjkKNmM2NTNkMjI3MzUyNDc0MjIwNDk0NTQzMzYzMTM5MzYzNjJkMzIyZTMxMjIwYTIwMjAyMDcwNjg2Zjc0NmY3MzY4NmY3MDNhCjQzNmY2YzZmNzI0ZDZmNjQ2NTNkMjIzMzIyMGEyMDIwMjA2NDYzM2E2NjZmNzI2ZDYxNzQzZDIyNjk2ZDYxNjc2NTJmNzA2ZQo2NzIyMGEyMDIwMjA3ODZkNzA0ZDRkM2E0OTZlNzM3NDYxNmU2MzY1NDk0NDNkMjI3ODZkNzAyZTY5Njk2NDNhMzI2NjM1MzIKNjU2NDMwNjIyZDM1MzgzNTYyMmQ2NDYyMzQ2MTJkNjEzMzM3MzcyZDYzMzIzNzMyNjI2NDM2NjEzNzY0MzgzNTIyMGEyMDIwCjIwNzg2ZDcwNGQ0ZDNhNDQ2ZjYzNzU2ZDY1NmU3NDQ5NDQzZDIyNjE2NDZmNjI2NTNhNjQ2ZjYzNjk2NDNhNzA2ODZmNzQ2Zgo3MzY4NmY3MDNhMzk2NTMxMzI2MzM5NjMzOTJkMzUzNzMwMzYyZDMxMzE2NTY0MmQ2MjMzMzczMTJkNjYzOTYyMzU2MzM0NjIKMzIzMDMyMzUzMzIyMGEyMDIwMjA3ODZkNzA0ZDRkM2E0ZjcyNjk2NzY5NmU2MTZjNDQ2ZjYzNzU2ZDY1NmU3NDQ5NDQzZDIyCjc4NmQ3MDJlNjQ2OTY0M2E2MTM5MzgzMDY1MzQzNjM0MmQzMTM1NjQzOTJkNjU2NDM0MzUyZDM4MzY2NTMzMmQzMDYxNjUzOAozMDM2NjUzNzMxMzkzMzM5MjIwYTIwMjAyMDY1Nzg2OTY2M2E1MDY5Nzg2NTZjNTg0NDY5NmQ2NTZlNzM2OTZmNmUzZDIyMzcKMzUzMDIyMGEyMDIwMjA2NTc4Njk2NjNhNTA2OTc4NjU2YzU5NDQ2OTZkNjU2ZTczNjk2ZjZlM2QyMjM2MzQzNzIyMGEyMDIwCjIwNjU3ODY5NjYzYTQzNmY2YzZmNzI1MzcwNjE2MzY1M2QyMjMxMjIwYTIwMjAyMDc4NmQ3MDNhNDM3MjY1NjE3NDZmNzI1NAo2ZjZmNmMzZDIyNDE2NDZmNjI2NTIwNTA2ODZmNzQ2ZjczNjg2ZjcwMjA0NTZjNjU2ZDY1NmU3NDczMjAzMTM0MmUzMDIwMjgKNTc2OTZlNjQ2Zjc3NzMyOTIyMGEyMDIwMjA3ODZkNzAzYTRkNmY2NDY5NjY3OTQ0NjE3NDY1M2QyMjIyMGEyMDIwMjA3ODZkCjcwM2E0MzcyNjU2MTc0NjU0NDYxNzQ2NTNkMjIzMjMwMzIzMjJkMzEzMDJkMzIzODU0MzEzNzNhMzIzMjNhMzMzODJkMzAzNAozYTMwMzAyMjBhMjAyMDIwNzg2ZDcwM2E0ZDY1NzQ2MTY0NjE3NDYxNDQ2MTc0NjUzZDIyMjIzZTBhMjAyMDIwM2M3MDY4NmYKNzQ2ZjczNjg2ZjcwM2E0NDZmNjM3NTZkNjU2ZTc0NDE2ZTYzNjU3Mzc0NmY3MjczM2UwYTIwMjAyMDIwM2M3MjY0NjYzYTQyCjYxNjczZTBhMjAyMDIwMjAyMDNjNzI2NDY2M2E2YzY5M2UzOTMwMzM0NTMzMzA0MTM1MzUzOTM3MzMzNTQzMzQzOTM4Mzc0Mwo0NjQxMzk0MTMyMzYzMzQ2NDQzNjM3Mzg0MjNjMmY3MjY0NjYzYTZjNjkzZTBhMjAyMDIwMjAyMDNjNzI2NDY2M2E2YzY5M2UKNjE2NDZmNjI2NTNhNjQ2ZjYzNjk2NDNhNzA2ODZmNzQ2ZjczNjg2ZjcwM2EzNzY0MzAzMDMyNjY2MzM4MmQzNTM3MzAzNjJkCjMxMzE2NTY0MmQ2MjMzMzczMTJkNjYzOTYyMzU2MzM0NjIzMjMwMzIzNTMzM2MyZjcyNjQ2NjNhNmM2OTNlMGEyMDIwMjAyMAozYzJmNzI2NDY2M2E0MjYxNjczZTBhMjAyMDIwM2MyZjcwNjg2Zjc0NmY3MzY4NmY3MDNhNDQ2ZjYzNzU2ZDY1NmU3NDQxNmUKNjM2NTczNzQ2ZjcyNzMzZTBhMjAyMDIwM2M3ODZkNzA0ZDRkM2E0ODY5NzM3NDZmNzI3OTNlMGEyMDIwMjAyMDNjNzI2NDY2CjNhNTM2NTcxM2UwYTIwMjAyMDIwMjAzYzcyNjQ2NjNhNmM2OTBhMjAyMDIwMjAyMDIwNzM3NDQ1NzY3NDNhNjE2Mzc0Njk2Zgo2ZTNkMjI2MzcyNjU2MTc0NjU2NDIyMGEyMDIwMjAyMDIwMjA3Mzc0NDU3Njc0M2E2OTZlNzM3NDYxNmU2MzY1NDk0NDNkMjIKNzg2ZDcwMmU2OTY5NjQzYTYxMzkzODMwNjUzNDM2MzQyZDMxMzU2NDM5MmQ2NTY0MzQzNTJkMzgzNjY1MzMyZDMwNjE2NTM4CjMwMzY2NTM3MzEzOTMzMzkyMjBhMjAyMDIwMjAyMDIwNzM3NDQ1NzY3NDNhNzM2ZjY2NzQ3NzYxNzI2NTQxNjc2NTZlNzQzZAoyMjQxNjQ2ZjYyNjUyMDUwNjg2Zjc0NmY3MzY4NmY3MDIwNDU2YzY1NmQ2NTZlNzQ3MzIwMzEzNDJlMzAyMDI4NTc2OTZlNjQKNmY3NzczMjkyMjBhMjAyMDIwMjAyMDIwNzM3NDQ1NzY3NDNhNzc2ODY1NmUzZDIyMjIyZjNlMGEyMDIwMjAyMDIwM2M3MjY0CjY2M2E2YzY5MGEyMDIwMjAyMDIwMjA3Mzc0NDU3Njc0M2E2MTYzNzQ2OTZmNmUzZDIyNzM2MTc2NjU2NDIyMGEyMDIwMjAyMAoyMDIwNzM3NDQ1NzY3NDNhNjM2ODYxNmU2NzY1NjQzZDIyMmYyMjBhMjAyMDIwMjAyMDIwNzM3NDQ1NzY3NDNhNjk2ZTczNzQKNjE2ZTYzNjU0OTQ0M2QyMjc4NmQ3MDJlNjk2OTY0M2EzMjY2MzUzMjY1NjQzMDYyMmQzNTM4MzU2MjJkNjQ2MjM0NjEyZDYxCjMzMzczNzJkNjMzMjM3MzI2MjY0MzY2MTM3NjQzODM1MjIwYTIwMjAyMDIwMjAyMDczNzQ0NTc2NzQzYTczNmY2Njc0Nzc2MQo3MjY1NDE2NzY1NmU3NDNkMjI0MTY0NmY2MjY1MjA1MDY4NmY3NDZmNzM2ODZmNzAyMDQ1NmM2NTZkNjU2ZTc0NzMyMDMxMzQKMmUzMDIwMjg1NzY5NmU2NDZmNzc3MzI5MjIwYTIwMjAyMDIwMjAyMDczNzQ0NTc2NzQzYTc3Njg2NTZlM2QyMjIyMmYzZTBhCjIwMjAyMDIwM2MyZjcyNjQ2NjNhNTM2NTcxM2UwYTIwMjAyMDNjMmY3ODZkNzA0ZDRkM2E0ODY5NzM3NDZmNzI3OTNlMGEyMAoyMDNjMmY3MjY0NjYzYTQ0NjU3MzYzNzI2OTcwNzQ2OTZmNmUzZTBhMjAzYzJmNzI2NDY2M2E1MjQ0NDYzZTBhM2MyZjc4M2EKNzg2ZDcwNmQ2NTc0NjEzZTBhMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwCjIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMAoyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAKMjAwYTIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwCjIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMAoyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAwYTIwMjAyMDIwMjAKMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwCjIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMAoyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMGEyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAKMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwCjIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMAoyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDBhMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAKMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwCjIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMAoyMDIwMjAyMDIwMjAyMDIwMjAwYTIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAKMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwCjIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMAoyMDIwMGEyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAKMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwCjIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMGEyMDIwMjAyMAoyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAKMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwCjIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDBhMjAyMDIwMjAyMDIwMjAyMDIwMjAyMAoyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAKMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwCjIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAwYTIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMAoyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAKMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwCjIwMjAyMDIwMjAyMDIwMjAyMDIwMGEyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMAoyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAKMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwCjIwMjAyMDBhMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMAoyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAKMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDBhMjAyMDIwCjIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMAoyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAKMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAwYTIwMjAyMDIwMjAyMDIwMjAyMDIwCjIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMAoyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAKMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMGEyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwCjIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMAoyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAKMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDBhMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwCjIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMAoyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAKMjAyMDIwMjAwYTIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwCjIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMAoyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAwYTIwMjAKMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwCjIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMAoyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMGEyMDIwMjAyMDIwMjAyMDIwMjAKMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwCjIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMAoyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDBhMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAKMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwCjIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMAoyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAwYTIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAyMDIwMjAKMjAyMDIwMjAwYTNjM2Y3ODcwNjE2MzZiNjU3NDIwNjU2ZTY0M2QyMjc3MjIzZjNlCq00Iv8AAAfrSURBVHgB7VoJbBRVGJ57r14LpdXStaUIJDYgauRuQgAhWqVR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",
    effect_absolute_solver_secondary = "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",
}
for k, v in pairs(textures) do
    textures[k] = "blank.png^[png:" .. textures[k]
end
table.update(magikacia.textures, textures)

