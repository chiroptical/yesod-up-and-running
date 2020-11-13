{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeApplications #-}

module Database.Donor where

import Control.Monad.IO.Class (MonadIO)
import Data.Donor
import Database.Persist
import Database.Persist.Sql (fromSqlKey, toSqlKey)
import Import (Int64, SqlPersistT, ($>))
import Model

toDonor :: DonorEntity -> Donor
toDonor DonorEntity{..} =
    Donor donorEntityBloodType donorEntityContactNumber donorEntityDateOfBirth donorEntityEmergencyContactNumber donorEntityFirstName donorEntityFirstTimeDonor donorEntityLastName

toDonorEntity :: Donor -> DonorEntity
toDonorEntity Donor{..} = DonorEntity donorBloodType donorContactNumber donorDateOfBirth donorEmergencyContactNumber donorFirstName donorFirstTime donorLastName

createDonor :: MonadIO m => Donor -> SqlPersistT m (Int64, Donor)
createDonor donor = do
    Entity{..} <- insertEntity $ toDonorEntity donor
    pure $ (fromSqlKey entityKey, toDonor entityVal)

entityToDonor :: Entity DonorEntity -> Donor
entityToDonor Entity{..} =
    toDonor entityVal

readDonors :: MonadIO m => SqlPersistT m [Donor]
readDonors = do
    donorEntities <- selectList @_ @_ @DonorEntity [] []
    pure $ entityToDonor <$> donorEntities

readDonor :: MonadIO m => Int64 -> SqlPersistT m (Maybe Donor)
readDonor = (fmap . fmap) toDonor . get . toSqlKey @DonorEntity

updateDonor :: MonadIO m => Int64 -> Donor -> SqlPersistT m ()
updateDonor ident donor@Donor{..} =
    repsert (toSqlKey ident) (toDonorEntity donor)

deleteDonor :: MonadIO m => Int64 -> SqlPersistT m (Maybe (Key DonorEntity))
deleteDonor ident = do
    let key = toSqlKey @DonorEntity ident
    mKey <- get key
    case mKey of
        Nothing -> pure Nothing
        Just _ -> delete key $> Just key
