// Example file of a helper module for a node.js app

import {db} from "../firebaseConfig.js"
import {instruments} from "../constants.js"
import {getDownloadUrl, getDownloadUrls} from "../utils.js"

async function getSchools(instrumentIds, userId) {
   const collectionRef = db.collection("schools")
   let data
   if (instrumentIds) {
      const instruments = instrumentIds.split(",")
      data = await collectionRef
         .where("lessons", "array-contains-any", instruments)
         .get()
   } else {
      data = await collectionRef.get()
   }
   if (data.empty) {
      return null
   }
   const schools = []
   for (const index in data.docs) {
      const school = await formatSchool(data.docs[index], userId)
      schools.push(school)
   }
   return schools
}

async function getSchoolById(id) {
   const data = await db.collection("schools").doc(id).get()
   if (data.empty) {
      return null
   }
   const school = await formatSchool(data)
   return school
}

// ---- funcion auxiliar para formatear escuela ----

async function formatSchool(school, userId) {
   const schoolInstruments = []
   for (const index in school.data().lessons) {
      const instrument = instruments.find(
         instrument => instrument.id == school.data().lessons[index]
      )
      schoolInstruments.push(instrument)
   }
   schoolInstruments.sort((a, b) => a.name.localeCompare(b.name))
   // check if the school is saved by the user
   let isSaved = false
   if (userId) {
      isSaved = school.data().savedBy.includes(userId)
   }
   const data = {
      id: school.id,
      ...school.data(),
      lessons: schoolInstruments,
      saved: isSaved,
      logo: await getDownloadUrl(school.data().logo),
      pictures: await getDownloadUrls(school.data().pictures),
   }
   return data
}

export {getSchools, getSchoolById}
