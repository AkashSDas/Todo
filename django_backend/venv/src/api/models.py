from django.db import models


class Todo(models.Model):
    LOW = 0
    MEDIUM = 1
    HIGH = 2
    PRIORITY_CHOICES = (
        (LOW, 'Low'),
        (MEDIUM, 'Medium'),
        (HIGH, 'High')
    )

    title = models.CharField(max_length=100)
    description = models.CharField(max_length=255)
    is_completed = models.BooleanField(default=False)
    deadline = models.CharField(max_length=20, blank=True, null=True)
    priority = models.IntegerField(default=LOW, choices=PRIORITY_CHOICES)

    def __str__(self):
        return self.title
