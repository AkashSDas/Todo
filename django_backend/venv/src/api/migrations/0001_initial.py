# Generated by Django 3.1 on 2020-08-31 07:38

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Todo',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=100)),
                ('description', models.CharField(max_length=255)),
                ('is_completed', models.BooleanField(default=False)),
                ('deadline', models.CharField(blank=True, max_length=10, null=True)),
                ('priority', models.IntegerField(choices=[(0, 'Low'), (1, 'Medium'), (2, 'High')], default=0)),
            ],
        ),
    ]
